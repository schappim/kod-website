# Default Page Parts

UPDATE: This extension has been modded to use YAML style config settings as opposed to comma separtated. You now have the ability to set the filter for page parts due to this change. It simply uses some code from the original default\_page\_parts extension by Andrea Franz of GravityBlast.

This extension is a complete hack. It depends heavily upon how Radiant's PageController creates new pages. It overrides Page#parent= to look for a 'page\_part\_config' page part that should contain a yaml formatted list of page parts to create in the new child page. As with most things in life, use it at your own risk.

So it's a hack, but a useful one. Since this extension monkeypatches class Page, it doesn't require your parent page to have a specific Page Type. You're free to use it on parent pages that might be Mailers, Archives, or any other Page Type. 

## How to use it

Let's say you want all pages under "Events" to have the page parts "location", "description" and "date" by default. 
Simply add a "page_part_config" page part to the "Events" page. In the content of that page part, put: 

    ---
    - name: location
      filter: none
    - name: description
      filter: markdown
    - name: date
      filter: none

As a result, every child of this page will have a `location`, `description` and `date` page part. Additionally, as shown in the code example, you can set the filter of each page part individually. It's great for small bits of information like dates or small single paragraph descriptions.

You can also do something like below when you only need parts and no default filters.

	---
	- name: location
	- name: description
	- name: date


  
