#!/bin/bash
#--ver 1.0
#	capable to slide the pictures from a folder
#	animation

#--ver 1.2
#	added "event" folder -- if the 'event' is empty play the pictures from 'regular'
#	slide timer fixed
#	auto-refresh

#--ver 1.3
#	fixed blinking animation in case of one picture
#	fixed sizing: fullHD compatible

#--ver 1.4
#	ALPHA -- Running text (reading it from a file) feature on the bottom of the screen. 
#	fixed UTF-8 coding 
#	randomized order in case of regular 
#
#--ver 1.5
#	ALPHA -- video playing



if [ $(ls /mnt/hdd/web/data/event | wc -l) == 0 ]
then
	ls /mnt/hdd/web/data/regular > pic_names
	data=$(sort -R pic_names)
	location='data/regular'
	counter=$(ls /mnt/hdd/web/data/regular | wc -l)
else
	data=$(ls /mnt/hdd/web/data/event)
	location='data/event'
	counter=$(ls /mnt/hdd/web/data/event | wc -l)
fi

if [ $(ls /mnt/hdd/web/data/video | wc -l)  != 0 ]
then
	video=$(ls /mnt/hdd/web/data/video)
	echo '<!DOCTYPE html>'
	echo '<html> '
	echo '<body> '
	echo '<video muted preload="none">'
	echo "  <source id=\"mp4\" src=\"/mnt/hdd/web/data/video/$video\" type=\"video/mp4\">"
	echo 'Your browser does not support HTML video.'
	echo '</video>'
	echo '</body> '
	echo '</html>'
	exit
fi

running_text=$(cat running_text.txt)
timer=10000 #5sec slide time
refresh_counter=$(((timer * counter)))
refresh_counter=$(((refresh_counter / 1000)))
echo '<!DOCTYPE html>'
echo '<html>'
echo '<meta charset="UTF-8">'
echo '<head>'
echo '<meta name="viewport" content="width=device-width, initial-scale=1">'
echo "<meta http-equiv=\"refresh\" content=\"$refresh_counter;url=index.html\">"
echo '<style>'
echo '* {box-sizing: border-box}'
echo 'body {font-family: Verdana, sans-serif; margin:0}'
echo '.mySlides {display: none}'
echo 'img {vertical-align: middle;}'
echo ''
echo '/* Slideshow container */'
echo '.slideshow-container {'
echo '  position: relative;'
echo '}'
echo '/* On hover, add a black background color with a little bit see-through */'
echo '.prev:hover, .next:hover {'
echo '  background-color: rgba(0,0,0,0.8);'
echo '}'
echo '/* Fading animation */'
echo '.fade {'
echo '  -webkit-animation-name: fade;'
echo '  -webkit-animation-duration: 3.5s;'
echo '  animation-name: fade;'
echo '  animation-duration: 3.5s;'
echo '}'
echo '@-webkit-keyframes fade {'
echo '  from {opacity: .4} '
echo '  to {opacity: 1}'
echo '}'
echo '@keyframes fade {'
echo '  from {opacity: .4} '
echo '  to {opacity: 1}'
echo '}'
echo '</style>'
echo '</head>'
echo '<body>'
echo '<div class="slideshow-container">'

for i in $data
do
	if [ $counter == 1 ]
		then 
			echo '<div class="mySlides">'
		else
			echo '<div class="mySlides fade">'
	fi
	echo "  <img src=\"$location/$i\" width=\"1920\" height=\"1080\">"
#	echo "  <img src=\"$location/$i\" width=\"100%\" height=\"100%\">"
	echo '</div>'
	echo ""
done
echo '</div>'
echo '<script>'
echo 'var slideIndex = 0;'
echo 'showSlides();'
echo ''
echo 'function showSlides() {'
echo '  var i;'
echo '  var slides = document.getElementsByClassName("mySlides");'
echo '  for (i = 0; i < slides.length; i++) {'
echo '    slides[i].style.display = "none";  '
echo '  }'
echo '  slideIndex++;'
echo '  if (slideIndex > slides.length) {slideIndex = 1}    '
echo ''
echo '  slides[slideIndex-1].style.display = "block";  '
echo "  setTimeout(showSlides, $timer); "
echo '}'
echo '</script>'
echo '    <style style="text/css">'
echo '        .marquee {'
echo '            height: 50px;'
echo '            overflow: hidden;'
echo '            position: relative;'
echo '            background: #fefefe;'
echo '            color: #333;'
echo '            border: 1px solid #4a4a4a;'
echo '        }'
echo '        '
echo '        .marquee p {'
echo '            position: absolute;'
echo '            width: 100%;'
echo '            height: 100%;'
echo '            margin: 0;'
echo '            line-height: 50px;'
echo '            text-align: center;'
echo '			  font-size: 100%'
echo '            -moz-transform: translateX(100%);'
echo '            -webkit-transform: translateX(100%);'
echo '            transform: translateX(100%);'
echo '            -moz-animation: scroll-left 2s linear infinite;'
echo '            -webkit-animation: scroll-left 2s linear infinite;'
echo '            animation: scroll-left 20s linear infinite;'
echo '        }'
echo '        '
echo '        @-moz-keyframes scroll-left {'
echo '            0% {'
echo '                -moz-transform: translateX(100%);'
echo '            }'
echo '            100% {'
echo '                -moz-transform: translateX(-100%);'
echo '            }'
echo '        }'
echo '        '
echo '        @-webkit-keyframes scroll-left {'
echo '            0% {'
echo '                -webkit-transform: translateX(100%);'
echo '            }'
echo '            100% {'
echo '                -webkit-transform: translateX(-100%);'
echo '            }'
echo '        }'
echo '        '
echo '        @keyframes scroll-left {'
echo '            0% {'
echo '                -moz-transform: translateX(100%);'
echo '                -webkit-transform: translateX(100%);'
echo '                transform: translateX(100%);'
echo '            }'
echo '            100% {'
echo '                -moz-transform: translateX(-100%);'
echo '                -webkit-transform: translateX(-100%);'
echo '                transform: translateX(-100%);'
echo '            }'
echo '        }'
echo '    </style>'
echo ''
echo '    <div class="marquee">'
echo "        <p style=\"font-size:30px\"> $running_text"
echo '    </div>'
echo '</body>'
echo '</html> '