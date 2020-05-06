#!/bin/bash

#ver 1.0
#	capable to slide the pictures from a folder
#	animation

#ver 1.2
#	added "event" folder -- if there is any picture in folder "event" it plays from that folder
#	slide timer fixed
#	auto-refresh

#ver 1.3
#	fixed blinking animation in case of one picture
#	fixed sizing: fullHD compatible

#if the 'event' is empty play the pictures from 'regular'


hour=$(date +"%H")
minute=$(date +"%M")
if [ $(ls /var/www/html/folders/event | wc -l) == 0 ]
then
	if  (($hour % 2))
	then
        if [[ $minute -gt 30 ]]
        then
            data=$(ls /var/www/html/folders/fontos)
			location='folders/fontos'
			counter=$(ls /var/www/html/folders/fontos | wc -l)
        else
            data=$(ls /var/www/html/folders/altalanos)
			location='folders/altalanos'
			counter=$(ls /var/www/html/folders/altalanos | wc -l)
        fi
	else
        data=$(ls /var/www/html/folders/altalanos)
		location='folders/altalanos'
		counter=$(ls /var/www/html/folders/altalanos | wc -l)
	fi
else
	data=$(ls /var/www/html/folders/event)
	location='folders/event'
	counter=$(ls /var/www/html/folders/event | wc -l)
fi


data=( $(shuf -e "${data[@]}") )

timer=10000 #10sec slide time
refresh_counter=$(((timer * counter)))
refresh_counter=$(((refresh_counter / 1000)))
echo '<!DOCTYPE html>'
echo '<html>'
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
echo '</body>'
echo '</html> '