#!/bin/sh
# Samuel Dudík

create_post() {
	md_target=$1

	title=$(head -n 1 "$md_target" | cut -c 3-)
	url_title=$(echo "$title" | tr ' ' '-' | tr '[:upper:]' '[:lower:]')
	
	filename=$posts_folder/$url_title
	
	mv $md_target "$filename.md"
	
	# insert title into the title tag
	sed "0,/<title><\/title>/s//<title>$title<\/title>/" header.html > "$filename.html"
	
	date=$(date +'%m-%d-%Y')
	
	lowdown "$posts_folder/$url_title.md" --html-no-head-ids >> "$filename.html"
	sed -i"" "/<\/h1>/a \\\n<p>Posted on $date</p>" "$filename.html"
	cat footer.html >> "$filename.html"
	
	sed -i"" "/<ul id=\"posts\">/a \\\t\t\t<li><span>$date </span><a href=\"$filename.html\">$title</a></li>" index.html
}

posts_folder="posts"

if [ -n "$1" ]; then
	if [ -f "$1" ]; then
		create_post $1

		exit 0		
	fi
	exit 1
fi

vim temp.md

if [ ! -f temp.md ]; then
	exit 1
fi

create_post temp.md