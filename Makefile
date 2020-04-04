all: clean build

DATESTAMP=$(shell /bin/date "+%Y-%m-%d")
TIMESTAMP=$(shell /bin/date "+%Y-%m-%d %H:%M:%S")

export DATESTAMP
export TIMESTAMP

define PRAEAMBLE
---
title: "FIXME"
image: "/images/sXeXX.jpg"
excerpt: "XXX"
tags: [ "Baldur's Gate: Descent into Avernus", "BGDiA", "Frontpage"]
---

endef

export PRAEAMBLE

new:
	@read -p 'episode: ' EPISODE; \
	echo "$$PRAEAMBLE" > _posts/${DATESTAMP}-$$EPISODE.md; \
	echo "" >> _posts/${DATESTAMP}-$$EPISODE.md; \
	vim _posts/${DATESTAMP}-$$EPISODE.md

build:
	bundle exec jekyll b

clean:
	$(RM) -rf _site/*

serve:
	bundle exec jekyll serve --drafts
