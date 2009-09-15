<?php
$index = 0;
$webpath = '';
$websubpath = '';
$docroot = realpath($_SERVER['DOCUMENT_ROOT']); // resolves symbolic links
$name = $_SERVER['SERVER_NAME'];

$dirname = realpath(dirname(__FILE__)); // This works on PHP >= 4.0.2
$directories = explode(DIRECTORY_SEPARATOR, $dirname); // System independent dir separator
$webroot_dirs = explode(DIRECTORY_SEPARATOR, $docroot);

foreach ( $directories as $dir ) {
	$w_dir = $webroot_dirs[$index];
	if ( $w_dir == $dir && $dir != '' && $w_dir != '' ) { // craft the webroot path without trailing slash
		$webpath .= '/' . $w_dir;
	}
	else{ // now we know where the subdirectory starts, and webroot ends
		if ( $dir != '' )  // craft web sub directory path without trailing slash
			$websubpath .= '/' . $dir;
	}
	++$index;
}
//use absolute form post url
$redirectpath = 'http://' . $name . $websubpath . '/portfolio/';
header('Location:' . $redirectpath);
?>
