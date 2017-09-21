class HomeController < ApplicationController

  def index
    @python_version = %x( python --version )
  end

  def test
    @image_paths = ['lib/assets/satelite/images/test_images/beach.jpg', 'lib/assets/satelite/images/test_images/beach1.jpeg']
    @result = "{'lib/assets/satelite/images/test_images/beach.jpg': [{'type': 'beach', 'score': 0.8391754}, {'type': 'baseballdiamond', 'score': 0.030107718}], 'lib/assets/satelite/images/test_images/beach1.jpeg': [{'type': 'beach', 'score': 0.74076998}, {'type': 'storagetanks', 'score': 0.088945538}]}"
  end


  def error_404
    render_optional_error(404)
  end
end
