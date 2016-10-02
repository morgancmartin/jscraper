class DriveController < ApplicationController

  def new
    @request = DriveEditor.new.request_url
  end

  def create
    de = DriveEditor.new
    @token = de.set_access_token(params[:code])
    session[:token] = @token
    de.list_files
    file = de.get_file_by_name('morgan_martin_cl_wd2016')
    de.export_file_by_id(file.id, 'gen.txt')
    @lines = []
    File.open('gen.txt', 'r').each do |line|
      @lines << line
    end
    render :new
  end
end
