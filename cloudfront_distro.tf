resource "aws_cloudfront_distribution" "static_site_distro" {
  origin {
    domain_name = aws_s3_bucket.static_site.bucket_regional_domain_name
    origin_id = "s3-origin"
  }
  enabled = true
  default_root_object = "index.html"
  default_cache_behavior {
    allowed_methods = ["GET","HEAD"]
    cached_methods = ["GET","HEAD"]
    viewer_protocol_policy = "redirect-to-https"
    target_origin_id = "s3-origin"
    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }
  viewer_certificate {
    cloudfront_default_certificate = true
  }
  restrictions {
    geo_restriction {
      restriction_type = "blacklist"
      locations = ["US","CA","DE"]
    }
  }
}