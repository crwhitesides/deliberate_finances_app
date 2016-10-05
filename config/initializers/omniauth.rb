Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, '9OkE8B5OrXUnqDQEba99nrP5j', '06l5Fhufhgh0gKmFNbvzNwcyDSLkG5dik2ip2FBa7GXB632F2m'
  provider :google_oauth2, '654909388655-5a52hff9muk724utrctjc0sjcbbbia66.apps.googleusercontent.com', 'sAQ5cCRlCSQzoAzt1GOs2QCS', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end
