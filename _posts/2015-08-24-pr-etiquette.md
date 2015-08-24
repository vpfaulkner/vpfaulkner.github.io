---
layout: post
title: PR Etiquette
---

Over the last few months I've been mulling through the right approach and mindset to take as a developer working as part of a team. Perhaps the most difficult part of development is the "people" aspect of it which is always challenging when working in a creative field where a lot of subjectivity is involved.

I've decided that every design decision falls somewhere on a spectrum between subjective and objective: some choices such as stylistic choices (think single quotes or double quotes in Ruby) are pretty subjective and the tradeoffs less evident or less important. Others such as the single responsibility principle or other "best practices" are taken to be a little more objectively better. Most choices, however, lie somewhere in the middle where the are at least some apparent tradeoffs, probably many others that you are not aware of at the moment, and the importance of which is can be difficult to tell. These ambiguous decisions can range from what to name certain variables to whether you use inheritance or not for a certain problem to the type of database. Everyone agrees that some choices are better than others and that there are design tradeoffs involved but there never is a clearcut choice.

Making matters worse, to be productive you generally need to take on a certain scope of work and make a series of these ambiguous choices on your own before submitting these to your peers as a proposal of work, typically as a pull request. This I've found is one of the most contentious part of working as part of a team and can benefit from some ground-rules that the team embraces:

## Accept that Some Choices are Subjective

Because many choices really are. Conflicts over this can be improved by choosing a style guide but you must begin by acknowledging this reality.

## Accept that Some Choices Matter More than Others

People themselves fit on a spectrum from purists to pragmatists and you should probably take some time to both locate yourself on this spectrum as well as your team. Startups, for example, almost have to be more pragmatically minded.

## Empower Everyone to Become Opinionated

As a new developer on a team, consciously or not you are taking in the team culture and the team values and your work will begin to reflect those to an extent in order to fit in. This is inevitable. But, some teams do a better job than others in emphasizing the importance of forming an opinion about what they think makes good design. On every part of a PR a developer should be able to confidently say why he or she made a certain design choice and know that they will not be ridiculed for such.

## Start with the Choices that Are More Objective and More Important

If you are submitting the PR, outline those major design decisions in the description. If you are reviewing the PR, focus first on those bigger decisions.

## Start with the Tradeoffs

More objective choices should have more evident tradeoffs. Discussing them as tradeoffs makes it less a conflict of opinions and thus of people and more a conflict between two designs. It is one more step removed from you as individuals.

## Accept that we are all Social Animals

In general, trying to take the focus off of individuals and more on the code is a great step forward but there will never be a time when egos are not involved. We are all social animals and all want to be respected and treated with courtesy. Acknowledge this and embrace it. The first rule when reviewing code should always be to treat one another with respect and courtesy no matter what the circumstance.




