Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'yFbqzAzWUPSJZaLDCQA', 'yZLMxkcnOA2IDCLo3twTU3uVLvL1l4foKznBOB7ADFA'
  provider :facebook, '175822172543011', '9a4f30e810a2013c96e5c00fa4f1b86d', :scope => 'publish_stream'
end

