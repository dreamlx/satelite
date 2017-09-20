class HomeController < ApplicationController

  def index
    @value = %x( python --version )
    @image_paths = ['app/assets/images/test_images/beach2.jpg', 'app/assets/images/test_images/beach1.jpeg']
    # @image_paths = ['lib/assets/satelite/images/test_images/beach.jpg', 'lib/assets/satelite/images/test_images/beach1.jpeg']
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
    end

  end

  def  test
    @image_paths = ['lib/assets/satelite/images/test_images/beach.jpg', 'lib/assets/satelite/images/test_images/beach1.jpeg']
    @result = "{'lib/assets/satelite/images/test_images/beach.jpg': [{'type': 'beach', 'score': 0.8391754}, {'type': 'baseballdiamond', 'score': 0.030107718}], 'lib/assets/satelite/images/test_images/beach1.jpeg': [{'type': 'beach', 'score': 0.74076998}, {'type': 'storagetanks', 'score': 0.088945538}]}"
  end


  def error_404
    render_optional_error(404)
  end
end
