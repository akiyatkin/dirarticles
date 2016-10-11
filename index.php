<?php
use infrajs\router\Router;
use infrajs\path\Path;
use infrajs\ans\Ans;
use infrajs\load\Load;
use infrajs\rubrics\Rubrics;
use infrajs\access\Access;

if (!is_file('vendor/autoload.php')) {
	chdir(explode('vendor/', __DIR__)[0]);
	require_once('vendor/autoload.php');
	Router::init();
}

$ans = array();

$lim = Ans::GET('lim', 'string', '0,100');
$p = explode(',', $lim);
if (sizeof($p) != 2) return Ans::err($ans, 'Некорректный параметр lim');
list($start, $count) = $p;

$src = Ans::GET('src', 'string');
if (!$src) return Ans::err($ans, 'Укажите обязательный параметр src');
if (!Path::isNest('~', $src)) return Ans::err($ans, 'Указан небезопасный путь src');


$id = Ans::GET('id');
if ($id) {
	$src = Rubrics::find($src, $id);
	if (isset($_GET['info'])) {
		$ans['info'] = Rubrics::info($src);
		return Ans::ret($ans); 
	} else {
		$text = Rubrics::article($src);
		return Ans::html($text);
	}
}

$order = Ans::GET('order',['descending', 'ascending'], 'descending');
$ans['order'] = $order;
$list = Access::cache(__FILE__, function ($src, $order) {
	$list = array();
	array_map(function ($file) use (&$list, $src) {
		if ($file{0} == '.') return;
		$file = Path::toutf($file);
		if (!Path::theme($src.$file)) return;
		$ext = Path::getExt($file);
		if (!in_array($ext, array('docx', 'tpl', 'html', 'php'))) return;
		$fd = Rubrics::info($src.$file);
		$list[] = $fd;
	}, scandir(Path::theme($src)));
	Load::sort($list, $order);
	return $list;
}, array($src, $order));

$list = array_slice($list, $start, $count);

$ans['dir'] = $src;
$ans['list'] = $list;


return Ans::ret($ans);