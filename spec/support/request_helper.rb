def parsed_body
  JSON.parse(response.body) if response.body
end
