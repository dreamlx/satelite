class PhotosController < ApplicationController
  def index
    @photo = Photo.new
    # require 'open3'
    # require 'pathname'
    # root_path = Pathname.new(__FILE__)
    # root_path = root_path.to_s.gsub('/app/controllers/photos_controller.rb', '')
    # images_path = "#{root_path}/public/test_images/beach1.jpeg"
    #
    # cmd = "python #{root_path}/lib/assets/satelite/retrain_model_classifier.py #{root_path}_,_#{images_path}"
    # Open3.popen3(cmd) do |stdin, stdout, stderr, wait_thread|
    #   @aa = {err: stderr.read.chomp,
    #          out: stdout.read.chomp
    #   }
    #   stdin.close
    # end

  end

  def create

    if params[:photo].present? && params[:photo][:name].present?
      image = Photo.create(name: params[:photo][:name])
      if !image.save
        flash[:error] = image.errors.full_messages[0]
        redirect_to photos_path
      else
        flash[:notice] = '上传成功'
        require 'open3'
        require 'pathname'
        root_path = Pathname.new(__FILE__)
        root_path = root_path.to_s.gsub('/app/controllers/photos_controller.rb', '')
        images_path = "#{root_path}/public#{image.name_url}"
        cmd = "python #{root_path}/lib/assets/satelite/retrain_model_classifier.py #{root_path}_,_#{images_path}"
        Open3.popen3(cmd) do |stdin, stdout, stderr, wait_thread|
          @result = {err: stderr.read.chomp, out: stdout.read.chomp}
          stdin.close
        end
        redirect_to "#{photos_path}?result=#{@result}&image_path=#{images_path}&root_path=#{root_path}"
      end
    else
      flash[:error] = '请上传一张图片'
      redirect_to photos_path
    end
  end


  def recognition

  end

  private

  def photo_params
    params.require(:photo).permit(:name)
  end
end