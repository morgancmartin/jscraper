require 'google/apis/drive_v2'
require 'google/api_client/client_secrets'
require 'google/apis/drive_v3'
require 'googleauth'
require 'googleauth/stores/file_token_store'

class DriveEditor

  def initialize
    client_secrets = Google::APIClient::ClientSecrets.load('client_secret.json')
    @auth_client = client_secrets.to_authorization
    puts 'AUTH CLIENT: '
    puts @auth_client
    @auth_client.update!(
      :scope => 'https://www.googleapis.com/auth/drive',
      :redirect_uri => 'http://localhost:3000/drive_redirect'
    )
  end

  def set_access_token(auth_code)
    @auth_client.code = auth_code
    @auth_client.fetch_access_token!
  end

  def get_file_by_name(name)
    authorize_service unless @service
    response = @service.list_files
    response.files.each do |file|
      return file if file.name == name
    end
    false
  end

  def export_file_by_id(id, path)
    @service.export_file(id, 'application/vnd.oasis.opendocument.text', download_dest: path)
  end

  def request_url
    @auth_client.authorization_uri.to_s
  end

  def list_files
    authorize_service unless @service
    response = @service.list_files
    response.files.each do |file|
      puts "#{file.name} (#{file.id})"
    end
  end

  # Initialize the API
  def authorize_service
    @service = Google::Apis::DriveV3::DriveService.new
    @service.client_options.application_name = 'Scraper'
    @service.authorization = @auth_client
  end
end
