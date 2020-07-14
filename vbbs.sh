#!/bin/sh

posts_folder="posts"

vim temp.md

if [ ! -f temp.md ]; then
	exit 1
fi

title=$(head -n 1 temp.md | cut -c 3-)
url_title=$(echo $title | tr ' ' '-' | tr '[:upper:]' '[:lower:]')

filename=$posts_folder/$url_title

mv temp.md $filename.md

# insert title into the title tag
sed "0,/<title><\/title>/s//<title>$title<\/title>/" header.html > $filename.html

date=$(date +'%m-%d-%Y')

lowdown $posts_folder/$url_title.md --html-no-head-ids >> $filename.html
sed -i"" "/<\/h1>/a \\\n<p>Posted on $date</p>" $filename.html
cat footer.html >> $filename.html

sed -i"" "/<ul id=\"posts\">/a \\\t\t\t<li><span>$date </span><a href=\"$filename.html\">$title</a></li>" index.html
