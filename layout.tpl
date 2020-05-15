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
		<li class="breadcrumb-item"><a href="/">Главная</a></li> 
		<li class="breadcrumb-item active">{config.title}</li>
	</ol>
	<h1>{config.title}</h1>
	{data.list::item}
</div>
{item:}
	<div class="row">
		<div class="col-sm-8">
			<a href="/{crumb.name}/{name}" class="title">{heading|title}</a>
			<div class="d-none d-sm-block">{preview}</div>
			{config.isdate?:idate}
		</div>
		<div class="col-sm-4">
			{gallery.0?:image}
			<div class="d-block d-sm-none">{preview}</div>
		</div>
	</div>
	<hr>
	{idate:}<div class="text-right"><i>{~date(:j F Y,date)}</i></div>
	{image:}
		<a class="thumbnail d-block mb-2" href="/{crumb.name}/{name}">
			<img class="img-thumbnail" src="/-imager/?src={gallerydir}{gallery.0.file}&w=256&or=-imager/empty.png" alt="{heading}">
		</a>
{PAGE:}
	<ol class="breadcrumb">
		<li class="breadcrumb-item"><a href="/">Главная</a></li> 
		<li class="breadcrumb-item"><a href="/{crumb.parent}">{parent.config.title}</a></li>
		<li class="breadcrumb-item active">{data.info.heading|data.info.title}</li>
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
	<script type="module">
		(async () => {
			let CDN = (await import('/vendor/akiyatkin/load/CDN.js')).default
			await CDN.load('magnific-popup')
			let div = document.getElementById('{div}')
			if (!div) return;
			div = $(div).find('.phorts-list');
			div.find('a').magnificPopup({
				type: 'image',
				gallery:{
					enabled:true
				}
			});
			var hash = location.hash;
			if (hash){
				hash = hash.replace(/^#/,'');
				if (hash=='show') {
					div.find('a:first').click();
				} else {
					
					var el = document.getElementById('img-'+hash);
					$(el).click();
				}
			}
		})()
	</script>
{bigimg:}<a id="img-{name}" href="/{...gallerydir}{file}"><img style="width:20%" src="/-imager/?w=400&h=300&crop=1&top=1&src={...gallerydir}{file}"></a>