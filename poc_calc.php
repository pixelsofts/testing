<?php
// Function to execute a command without waiting for output
function run_detached($cmd) {
    if (substr(php_uname(), 0, 7) == "Windows"){
        pclose(popen("start /B ". $cmd, "r")); 
    } else {
        exec($cmd . " > /dev/null &");  
    }
}

echo "[*] Attempting to spawn Calculator...\n";
// Attempt 1: Standard shell_exec (might hang the script until calc closes)
// shell_exec("calc.exe"); 

// Attempt 2: Detached process (Better for malware simulation)
run_detached("calc.exe");
echo "[+] Calculator spawned! Code execution confirmed.\n";
?>
