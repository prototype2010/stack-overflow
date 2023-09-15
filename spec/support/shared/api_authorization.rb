shared_examples_for 'API Authorizable' do
  it 'with no access token' do
    do_request(method.to_sym,api_path, headers: headers)
    expect(response.status).to eq 401
  end

  it 'with invalid access token' do
    do_request(method.to_sym, api_path ,params: {access_token: '1234'}, headers: headers)
    expect(response.status).to eq 401
  end
end
