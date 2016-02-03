Add-Type -AssemblyName System.Windows.Forms

$form = New-Object Windows.Forms.Form

$form.Size = New-Object Drawing.Size @(300,300)

$form.StartPosition = "CenterScreen"

$btn = New-Object System.Windows.Forms.Button
$btn.add_click( {Get-Date|Out-Host} )
$btn.Text = "Send Date"

$form.Controls.Add($btn)

$drc = $form.ShowDialog()

#Thoughts about having this run as a job or seperate process
#And to read output from the app, could be useful
