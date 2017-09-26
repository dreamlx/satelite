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
    respond_to do |format|
      if params[:photo].present? && params[:photo][:name].present?
        image = Photo.create(name: params[:photo][:name])
        if !image.save
          message = image.errors.full_messages[0]
          flash[:error] = message
          format.html { redirect_to photos_path, notice: "#{message}" }
          format.json { render json: {code: 1, message: message} }
        else
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
          output = @result[:out]
          message = '上传并识别成功'
          format.html { redirect_to "#{photos_path}?result=#{@result[:out]}&image_path=#{images_path}&root_path=#{root_path}", notice: "#{message}" }
          format.json { render json: {code: 0, message: message, data: eval(output)} }
        end
      else
        message = '请上传一张图片'
        format.html { redirect_to photos_path, notice: "#{message}" }
        format.json { render json: {code: 1, message: message} }
      end
    end
  end


  def recognition

  end

  private

  def photo_params
    params.require(:photo).permit(:name)
  end
end