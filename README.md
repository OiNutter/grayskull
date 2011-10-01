Grayskull
=========

Grayskull is a Ruby library for validating data files against custom schema. It currently validates YAML and JSON files. It can be used as a library in your 
ruby code and also comes with a command line tool.

Installation
------------

	gem install grayskull
	
Usage
-----

###Library###

	require 'grayskull'
	validator = Grayskull::Validator.new(file,schema)
	results = validator.validate
	
Grayskulls `validate` function will return one of the following Hashes.

Succes:
	
	{
		"result":true
	}
	
Failure:

	{
		"result":false,
		"errors":errors #Array of error messages
		
	}
	
###Command Line###

	grayskull validate path/to/file path/to/schema
	
###Schema Files###

Schema files should be in the following format:

YAML:

	sections:
      - name: section1 #section name
        required: yes yes|no
    	type: Array #Valid ruby type or a custom type as defined in types.
    	ok_empty: yes|no
        accepts: #list of accepted types
          - custom_type1
          - custom_type2
    types:
      custom_type1:
        type: Hash #Valid ruby type or a custom type as defined in types.
        ok_empty: yes|no 
        accepts:
          - String #list of accepted types
      custom_type2:
        type: Array
        ok_empty: yes|no
        accepts:
          - Array
      
JSON

	{
		"sections":[
					{
						"name": "section_name",
						"required": true|false,
						"type": "Array", #Valid ruby type or a custom type as defined in types.
						"ok_empty": true,
						"accepts":[ #list of accepted types
							"custom_type1",
							"String"
						]
					}
    			],
    	"types":{
    		"custom_type1":{
    			"type":"Hash",#Valid ruby type or a custom type as defined in types.
    			"ok_empty":true|false,
    			"accepts":[ #list of accepted types
    				"Hash"
    			]
			},
		}
	}
	
As all files are converted to native ruby formats you can mix json files with yaml schemas and vice versa.

Coming Soon
-----------

* More formats
* Unit Tests

Notes
-----

This is an extraction of the validation code from my first gem skeletor. I'm still pretty new to ruby so I'd be really grateful for any constructive feedback, input, suggestions etc. As usual, if anybody wants to
contribute feel free, just check out the guidelines below.

Contributing to Skeletor
------------------------
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

Copyright
---------

Copyright (c) 2011 OiNutter. See LICENSE.txt for
further details.