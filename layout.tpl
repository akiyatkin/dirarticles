<div class="dirarticles">
	<style scoped>
		.dirarticles .media {
			transition: 0.4s;
			cursor: pointer;
		}
	</style>
	<ol class="breadcrumb">
		<li><a href="/">Главная</a></li> 
		<li class="active">{config.title}</li>
	</ol>
	<h1>{config.title}</h1>
	{data.list::item}
	<script>
		domready( function () {
			$('.dirarticles').find('.media').click( function () {
				event.preventDefault();
				event.stopPropagation();
				Crumb.go($(this).find('a').attr('href'));
			});
		});
	</script>
</div>
{item:}
	<div class="media">
		<div class="media-left">
			<a href="/{crumb.name}/{name}">
				<img class="media-object" src="/-imager/?src={images.0.src}&w=256" alt="{heading}">
			</a>
		</div>
		<div class="media-body">
			<a href="/{crumb.name}/{name}"><h4 class="media-heading">{heading|title}</h4></a>
			{preview}
			<div class="text-right"><i>{~date(:j F Y,date)}</i></div>
		</div>
	</div>
{PAGE:}
	<ol class="breadcrumb">
		<li><a href="/">Главная</a></li> 
		<li><a href="/{crumb.parent}">{parent.config.title}</a></li>
		<li class="active">{data.info.heading|data.info.title}</li>
	</ol>
	<div id="dirart"></div>
	<p class="text-right">
		<i>{~date(:j F Y,data.info.date)}</i>
	</p>
	{:gallery}
	<p class="text-right">
		<a href="/{crumb.parent}">{parent.config.title}</a>
	</p>
{gallery:}
	<div class="phorts-list">
		<style scoped>
			.phorts-list {
				margin-left:-5px;
				margin-right:-5px;
			}
			.phorts-list img {
				padding:5px;
				width:20%;
			}
		</style>
		{data.info.gallery::bigimg}
	</div>
	<a href="/{parent.crumb}">{parent.config.title}</a>
	<script>
		domready(function(){
			var div = $('.phorts-list');
			if (!div.magnificPopup) {
				console.info('Требуется magnificPopup');
				return;
			}
			div.find('a').magnificPopup({
				type: 'image',
				gallery:{
					enabled:true
				}
			});
			var hash = location.hash;
			if(hash){
				hash = hash.replace(/^#/,'');
				if (hash=='show') {
					div.find('a:first').click();
				} else {
					
					var el = document.getElementById('img-'+hash);
					$(el).click();
				}
			}
		});
	</script>
{bigimg:}<a id="img-{.}" href="/{...gallerydir}{.}"><img style="width:20%" src="/-imager/?w=400&h=300&crop=1&src={...gallerydir}{.}"></a>