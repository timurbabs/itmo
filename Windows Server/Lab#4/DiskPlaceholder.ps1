﻿$count = 0
try
{
    while ($true)
    {
        $count++
        $objFile = [io.file]::Create("E:\$count.txt")
        $objFile.SetLength(1mb)
        $objFile.Close()
    }