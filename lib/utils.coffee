exports.getAllAttributes = (message) ->
  attributes = {}
  if message.MessageAttributes
    MessageAttrs = message.MessageAttributes
    for attributeKey in Object.keys(MessageAttrs)
      DataType = MessageAttrs[attributeKey].DataType
      subKey = DataType
      if DataType is 'Number'
        subKey = 'String'
      subKey = subKey + 'Value'
      if MessageAttrs[attributeKey][subKey] is 'true'
        MessageAttrs[attributeKey][subKey] = true
      attributes[attributeKey] = MessageAttrs[attributeKey][subKey]
      if DataType is 'Number'
        attributes[attributeKey] = Number(attributes[attributeKey])
  return attributes

exports.setAllAttributes = (attributes) ->
  returnValue = {}
  for attributeKey, attributeValue of attributes

    # fetch datatype from value
    DataType = getDataType(attributeValue)

    # begin setting the attribute
    returnValue[attributeKey] =
      DataType: DataType
      StringValue: String(attributeValue)

  return returnValue

# private
getDataType = (data) ->
  if !isNaN(data)
    return 'Number'
  return 'String'