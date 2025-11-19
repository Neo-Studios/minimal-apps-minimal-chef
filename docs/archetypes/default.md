+++
title = "{{ replace .File.ContentBaseName "-" " " | title }}"
description = "Brief description of this page for SEO"
weight = 50
draft = false
+++

## {{ replace .File.ContentBaseName "-" " " | title }}

Write your content here using Markdown.

### Section 1

Content for the first section.

### Section 2

Content for the second section.

## Tips

- Use `##` for main sections
- Use `###` for subsections
- Use fenced code blocks for code examples
- Set `draft = true` to hide the page while working on it
- Lower `weight` values appear first in section menus
