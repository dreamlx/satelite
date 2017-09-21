class PhotosController < ApplicationController
  def index
    @photo = Photo.new
  end

  def create

    if params[:photo].present? && params[:photo][:name].present?
      image = Photo.create(name: params[:photo][:name])
      if !image.save
        flash[:error] = image.errors.full_messages[0]
        redirect_to photos_path
      else
        flash[:notice] = '上传成功'
        @image_paths = ['../../../public'+image.name_url]
        ensure_file_exist = true
        @image_paths.each do |image_path|
          unless File.exist?(image_path)
            ensure_file_exist = false
            @not_exist_file = image_path
            break
          end
        end
        if ensure_file_exist
          @result = `python lib/assets/satelite/retrain_model_classifier.py #{@image_paths.join(',')}`
          redirect_to "#{photos_path}?result=#{@result}"
        else
          flash[:notice] = '500 error'
          redirect_to photos_path
        end
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