	
	// Cufon text replacememnt, add more elements to replace text with cufon generated text.
	Cufon.replace('h1, h2, h3, h4',{hover: true});
		
$(document).ready(function() { 
		
		//Main navigation dropdowns
        $('ul.sf-menu').superfish({ 
            delay:       300,                            // one second delay on mouseout 
            animation:   {height:'show'},  // fade-in and slide-down animation 
            speed:       'normal',                          // faster animation speed 
            autoArrows:  true,                           // disable generation of arrow mark-up 
            dropShadows: false                            // disable drop shadows 
        }); 
        
        //Nivo slider customization
        $(window).load(function() {
    	$('#slider').nivoSlider({
        effect:'fade', //Specify sets like: 'fold,fade,sliceDown'
        slices:20,
        animSpeed:800, //Slide transition speed
        pauseTime:5000,
        startSlide:0, //Set starting Slide (0 index)
        directionNav:true, //Next & Prev
        directionNavHide:true, //Only show on hover
        controlNav:false, //1,2,3...
        controlNavThumbs:false, //Use thumbnails for Control Nav
        controlNavThumbsFromRel:false, //Use image rel for thumbs
        controlNavThumbsSearch: '.jpg', //Replace this with...
        controlNavThumbsReplace: '_thumb.jpg', //...this in thumb Image src
        keyboardNav:true, //Use left & right arrows
        pauseOnHover:true, //Stop animation while hovering
        manualAdvance:false, //Force manual transitions
        captionOpacity:0.8, //Universal caption opacity
        beforeChange: function(){},
        afterChange: function(){},
        slideshowEnd: function(){}, //Triggers after all slides have been shown
        lastSlide: function(){}, //Triggers when last slide is shown
        afterLoad: function(){} //Triggers when slider has loaded
    	});
		});
        
		//Coin slider customization
		$('#coin-slider').coinslider({ width: 934, height: 335, navigation: true, opacity: 0.9 });
		
		//PrettyPhoto customization
		$(document).ready(function(){
			$("a[rel^='prettyPhoto']").prettyPhoto();
		});
				
}); 		
		


