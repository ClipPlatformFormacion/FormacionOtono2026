#Install-Module BcContainerHelper -Force

$artifact = Get-BCArtifactUrl -country es -select Latest -type Sandbox -version 29

$UserName = 'Alumno'
$Password = 'UnPassword'
$credential = New-Object pscredential $UserName, (ConvertTo-SecureString -String $Password -AsPlainText -Force)

New-BcContainer -containerName BC29CU1ES -artifactUrl $artifact -auth UserPassword -Credential $credential -accept_eula -includeTestToolkit -includeTestLibrariesOnly -updateHosts -useBestContainerOS