---
layout: post
title: Working with Files in Ruby
---

If you are mostly in the Rails world you probably are not dealing with files on a day to day basis. And if you do, most likely you would use a Gem such as Paperclip or Carrierwave. I recently had to build an endpoint for storing image files and was challenged to do so without an external gem. Moreover, part of the requirements was to whitelist the acceptable file formats by looking for a file signature in the first few bytes of the file (rather than just looking at the file extension which can be easily faked) and furthermore send the file data to an external object store.

This endpoint required files to be uploaded via a multipart-form post which, in Rails, would result in a tempfile. Tempfiles in Ruby are very similar to files:

{% highlight ruby %}
# Create a tempfile
require 'tempfile'

file = Tempfile.new('foo')
file.write("Bar")
file.rewind    # moves the cursor back to the beginning of the file
file.read      # => "hello world"
file.close     # files need to be manually closed
file.unlink    # deletes the temp file

# Create a file
file = File.new("new_file", "w")
file.write("new content")
file.read      # => "new content"
file.close
{% endhighlight %}

Since the API required a multipart-form post, users were asked to use "media" as the key attached to the file. In Rails you could access this like so:

{% highlight ruby %}
def uploaded_file
  params["media"].tempfile
rescue
  raise MediaAttachmentError
end
{% endhighlight %}

The tempfile will only leave during the life of the request. To do some validation, let's say we want to verify the type. To verify the type, I opted to look inside the file at its file signature or "magic number" for which I kept a whitelist:

{% highlight ruby %}
WHITE_LISTED_FORMATS = { "89504e470d0a1a0a" => "png" }

def detect_type
  # detect returns the key-value pair as an array
  WHITE_LISTED_FORMATS.detect do |format_sig, _format_name|
    format_match?(format_sig)
  end.try(:last)
end

def format_match?(format_sig)
  @file.rewind
  bytes_to_read = format_sig.length / 2
  @file.readpartial(bytes_to_read).unpack("H\*").first.downcase == format_sig
end
{% endhighlight %}

Let's walk through this step by step: The WHITE_LISTED_FORMATS is a constant where these acceptable signatures and their corresponding file extension are kept. Running detect against them will return the first format key and value that returns true from the block. I run try(:last) to get the file extension unless nil is returned, meaning the filetype is unacceptable. To actually verify the format, you need to read the first few bytes of the file as determined by the hex signature divided by 2. To actually to the comparison, you need to unpack the data you read as hex and compare it to the hex signature denoting the file type. Note: I do the rewind before actually reading the file; this is to be safe and ensure we are reading from the beginning of the file.

Hopefully this example gives you a sense of both how to deal with a file and why you might need to actually do so. Just be careful: some files can be very large and actually reading them can introduce a lot of latency into your response time. Handle with care.
