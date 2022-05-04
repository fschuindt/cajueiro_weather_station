module CajueiroWeatherStation
  module Features
    class GraphBuilderAndUploader
      def self.start(temperature_data_file)
        Thread.new do
          loop do
            graph_file = GraphFileGenerator.generate(temperature_data_file, 500, 250)
            upload_to_s3(graph_file)
            sleep 3600
          end
        end
      end

      def self.upload_to_s3(file_path)
        s3 = Aws::S3::Resource.new(
          credentials: Aws::Credentials.new(ENV["AWS_ACCESS_KEY_ID"], ENV["AWS_SECRET_ACCESS_KEY"]),
          region: ENV["AWS_REGION_ID"]
        )

        obj = s3.bucket(ENV["AWS_S3_BUCKET_NAME"]).object(File.basename(file_path))
        obj.upload_file(file_path, acl:'public-read', content_type: "image/png")
        obj.public_url
      end
    end
  end
end
