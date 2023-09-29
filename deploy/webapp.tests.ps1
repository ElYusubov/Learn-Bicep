param(
  [Parameter(Mandatory)]
  [ValidateNotNullOrEmpty()]
  [string] $HostNameUrl
)

Describe 'EADE Test WebApp' {

    It 'Serves pages over HTTPS' {
      $request = [System.Net.WebRequest]::Create("https://$HostNameUrl/")
      $request.AllowAutoRedirect = $false
      $request.GetResponse().StatusCode |
        Should -Be 200 -Because "the webapp requires HTTPS"
    }

    It 'Does not serves pages over HTTP' {
      $request = [System.Net.WebRequest]::Create("http://$HostNameUrl/")
      $request.AllowAutoRedirect = $false
      $request.GetResponse().StatusCode | 
        Should -BeGreaterOrEqual 300 -Because "HTTP is not secure"
    }

}