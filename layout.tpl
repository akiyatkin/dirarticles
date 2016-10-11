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
	<p class="text-right">
		<a href="/{crumb.parent}">{parent.config.title}</a>
	</p>
