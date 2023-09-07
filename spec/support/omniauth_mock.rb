module OmniauthMacros
  def mock_github
    # The mock_auth configuration allows you to set per-provider (or default)
    # authentication hashes to return during integration testing.
    OmniAuth.config.mock_auth[:github] =  OmniAuth::AuthHash.new({
      provider: 'github',
      uid: '18482106',
      info: {
        "nickname" => "prototype2010",
        "email" => "alex.zakorko2015@gmail.com",
        "name" => nil,
        "image" => "https://avatars.githubusercontent.com/u/18482106?v=4",
      }
    })
  end

  def mock_google
    OmniAuth.config.mock_auth[:google_oauth2] =
      OmniAuth::AuthHash.new({
        "provider":"google_oauth2",
        "uid":"107458856279189993458",
        "info": {
          "name":"Alexander Zakorko",
          "email":"alexander.zakorko@1648factory.com",
          "unverified_email":"alexander.zakorko@1648factory.com",
          "email_verified":true,
          "first_name":"Alexander",
          "last_name":"Zakorko",
          "image":"https://lh3.googleusercontent.com/a/ACg8ocLyhlt4zK12Y2tgqQXZdzAHTM8TD8XleyxY9qs5jIbKpg=s96-c"},
        "credentials":{
          "token":"ya29.a0AfB_byAvSVwln3NbvWAlG1Igxf0P2RCZ0Cc46_W6fxrGw1jycYCv1GVzhxgr_7bAd98bHdNkZqnv0hoqsQ2rOZZfAb5RU9mreKmdDFFBr03Af7MkSX0rnLUmDo27aZ4249z4GCk0208uuVIFutd_W2G4xAPn7sdiqAaCgYKAX0SARASFQGOcNnCjtC6MfL18LhTN0CsLXWZJw0169",
          "refresh_token":"1//0cUFrSQel9l3_CgYIARAAGAwSNwF-L9Irnt8lE1EBBb6p-O12wLFUVLIiEJ1zQ7SLImwfagSnQrzinSoBJCrCyyXIqZiaJkATJPc",
          "expires_at":1694321199,
          "expires":true,
          "scope":"https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/userinfo.profile openid"},
        "extra":{
          "id_token":"eyJhbGciOiJSUzI1NiIsImtpZCI6IjdjMGI2OTEzZmUxMzgyMGEzMzMzOTlhY2U0MjZlNzA1MzVhOWEwYmYiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiI3Njk4MTk2MjcxNjktYjhzNmFkNW43anQwa2lxdmlpcmhxczl2cGYxN3FzYzkuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiI3Njk4MTk2MjcxNjktYjhzNmFkNW43anQwa2lxdmlpcmhxczl2cGYxN3FzYzkuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMDc0NTg4NTYyNzkxODk5OTM0NTgiLCJoZCI6IjE2NDhmYWN0b3J5LmNvbSIsImVtYWlsIjoiYWxleGFuZGVyLnpha29ya29AMTY0OGZhY3RvcnkuY29tIiwiZW1haWxfdmVyaWZpZWQiOnRydWUsImF0X2hhc2giOiJ2WW5QdmlnUmZheDRUVkpHQm1xWFJ3IiwibmFtZSI6IkFsZXhhbmRlciBaYWtvcmtvIiwicGljdHVyZSI6Imh0dHBzOi8vbGgzLmdvb2dsZXVzZXJjb250ZW50LmNvbS9hL0FDZzhvY0x5aGx0NHpLMTJZMnRncVFYWmR6QUhUTThURDhYbGV5eFk5cXM1akliS3BnPXM5Ni1jIiwiZ2l2ZW5fbmFtZSI6IkFsZXhhbmRlciIsImZhbWlseV9uYW1lIjoiWmFrb3JrbyIsImxvY2FsZSI6ImVuIiwiaWF0IjoxNjk0MzE3NjAwLCJleHAiOjE2OTQzMjEyMDB9.HFy7SUeIFVXBSAkXWCQNSBhWrbV0lkeq8bo209NnGF92KFYynZ3WtQHGAPGE9k4PPv8wx4fCN_c87o8kQ_hQlZqGQrjTvtNmbCmOUFr2c9VVmaTS36QJxT8hbndfSH09VtGIn7kXkw2h1I71seX_D1bD4NNZ5KXmB2666sJK1SyCAAuNY9uQpQ0Zt87PbLUGY0ruibxJ4S0khIm4EqIBu95FwYAwx4wBKQvFZ-VtDqswv-vHslVlIo_knK9qe3eK8LV6hfOGxkJHvGGv8k1vMTfkSa2ZntiSOqrP_MyzAKitXepXcBq2QtCBx6pXV_ylNJR6ZTpFU59qF_txtSIYUg",
          "id_info": {
            "iss":"https://accounts.google.com",
            "azp":"769819627169-b8s6ad5n7jt0kiqviirhqs9vpf17qsc9.apps.googleusercontent.com",
            "aud":"769819627169-b8s6ad5n7jt0kiqviirhqs9vpf17qsc9.apps.googleusercontent.com",
            "sub":"107458856279189993458",
            "hd":"1648factory.com",
            "email":"alexander.zakorko@1648factory.com",
            "email_verified":true,
            "at_hash":"vYnPvigRfax4TVJGBmqXRw",
            "name":"Alexander Zakorko",
            "picture":"https://lh3.googleusercontent.com/a/ACg8ocLyhlt4zK12Y2tgqQXZdzAHTM8TD8XleyxY9qs5jIbKpg=s96-c",
            "given_name":"Alexander","family_name":"Zakorko","locale":"en","iat":1694317600,"exp":1694321200
          },
          "raw_info":{
            "sub":"107458856279189993458",
            "name":"Alexander Zakorko",
            "given_name":"Alexander",
            "family_name":"Zakorko",
            "picture":"https://lh3.googleusercontent.com/a/ACg8ocLyhlt4zK12Y2tgqQXZdzAHTM8TD8XleyxY9qs5jIbKpg=s96-c",
            "email":"alexander.zakorko@1648factory.com",
            "email_verified":true,
            "locale":"en",
            "hd":"1648factory.com"
          }
        } })
  end
end
