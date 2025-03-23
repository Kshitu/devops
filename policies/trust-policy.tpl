{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "${principal_service}"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
