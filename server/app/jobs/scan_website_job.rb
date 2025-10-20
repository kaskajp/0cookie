class ScanWebsiteJob < ApplicationJob
  queue_as :default

  def perform(website_id)
    # Placeholder: initiate a scan for the given website
  end
end
