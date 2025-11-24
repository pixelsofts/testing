<?php
// This requires the COM extension to be enabled in php.ini
echo "[*] Attempting to use WScript.Shell via COM...\n";

try {
    $wshell = new COM('WScript.Shell');
    // Run Notepad hidden (0) or visible (1)
    $wshell->Run('notepad.exe', 1, false);
    echo "[+] Notepad launched via COM object!\n";
} catch (Exception $e) {
    echo "[-] COM execution failed: " . $e->getMessage() . "\n";
    echo "[-] Hint: You probably need to enable 'extension=com_dotnet' in php.ini\n";
}
?>
