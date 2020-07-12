<?php
use infrajs\router\Router;
use infrajs\path\Path;
use infrajs\ans\Ans;
use infrajs\load\Load;
use infrajs\rubrics\Rubrics;
use infrajs\access\Access;


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
		if (!$src) {
			header("HTTP/1.0 404 Not Found");
			return;
		} else {
			$text = Rubrics::article($src);
			
			$removeh1 = isset($_GET['removeh1']);
			$headingstodiv = isset($_GET['headingstodiv']);

			if ($removeh1) {
				$text = preg_replace('/<h1[^>]*?>.*?<\/h1>/si', '', $text);
				
			}
			if ($headingstodiv) {
				$text = preg_replace('/<(h\d)[^>]*?>(.*?)<\/h\d>/si', '<div class="${1}">${2}</div>', $text);
			}
			if (Ans::isReturn()) return $text;
			echo $text;
			return;
		}
		return Ans::html($text);
	}
}
$istext = Ans::GET('text', 'bool', false);
$removeh1 = Ans::GET('text', 'string', '');
$order = Ans::GET('order',['descending', 'ascending'], 'descending');
$ans['order'] = $order;
$list = Access::cache(__FILE__, function ($src, $order, $istext, $removeh1) {
	$list = array();
	array_map(function ($file) use (&$list, $src, $istext, $removeh1) {
		if ($file{0} == '.') return;
		$file = Path::toutf($file);
		if (!Path::theme($src.$file)) return;
		$ext = Path::getExt($file);
		if (!in_array($ext, array('docx', 'tpl', 'html', 'php'))) return;
		$fd = Rubrics::info($src.$file);
		if ($istext) {
			$text = Rubrics::article($src.$file);
			if ($removeh1) {
				$text = preg_replace('/<h1[^>]*?>.*?<\/h1>/si', '', $text);
			}
			$fd['text'] = $text;
		}
		$list[] = $fd;
	}, scandir(Path::theme($src)));
	Load::sort($list, $order);
	return $list;
}, array($src, $order, $istext, $removeh1));

$list = array_slice($list, $start, $count);

$ans['dir'] = $src;
$ans['list'] = $list;


return Ans::ret($ans);