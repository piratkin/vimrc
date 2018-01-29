#!powershell

$path = '~\AppData\Local\nvim\autoload'
If(!(test-path $path))
{
    md $dir
}
$down = New-Object System.Net.WebClient;
$url  = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim';
$file = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath("$path/plug.vim");
$down.DownloadFile($url,$file);
