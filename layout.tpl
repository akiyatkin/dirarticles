<div class="dirarticles">
	<style scoped>
		.dirarticles .title {
			font-weight: bold;
			font-size:120%;
			display: block;
			margin-bottom:0.5em;
		}
	</style>
	<ol class="breadcrumb">
		<li><a href="/">Главная</a></li> 
		<li class="active">{config.title}</li>
	</ol>
	<h1>{config.title}</h1>
	{data.list::item}
</div>
{item:}
	<div class="row">
		<div class="col-sm-8">
			<a href="/{crumb.name}/{name}" class="title">{heading|title}</a>
			{preview}
			<div class="text-right"><i>{~date(:j F Y,date)}</i></div>
		</div>
		<div class="col-sm-4">
			{images.0.src?:image}
		</div>
	</div>
	<hr>
	{image:}
		<a class="thumbnail" style="margin:0" href="/{crumb.name}/{name}">
			<img src="/-imager/?src={images.0.src}&w=256&or=-imager/empty.png" alt="{heading}">
		</a>
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
	<div class="socialshares">
	  <div class="socialshares-twitter"></div>
	  <div class="socialshares-facebook"></div>
	  <div class="socialshares-vk"></div>
	</div>
	<script>
		domready(function(){
			socialshares.mount();
		});
	</script>
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
{bigimg:}<a id="img-{.}" href="/{...gallerydir}{.}"><img style="width:20%" src="/-imager/?w=400&h=300&crop=1&top=1&src={...gallerydir}{.}"></a>