describe '4.2.4 CALL' do
	include Kn::Test::Spec

	it 'should evaluate something returned by `BLOCK`' do
		assert_equal 12, eval('CALL BLOCK 12')
		assert_equal "12", eval('CALL BLOCK "12"')

		assert_equal true, eval('CALL BLOCK TRUE')
		assert_equal false, eval('CALL BLOCK FALSE')
		assert_equal :null, eval('CALL BLOCK NULL')

		assert_equal "twelve", eval('; = foo BLOCK bar ; = bar "twelve" : CALL foo')
		assert_equal 15, eval('; = foo BLOCK * x 5 ; = x 3 : CALL foo')
	end

	it 'should _only_ evaluate BLOCK return values', when_testing: :strict_compliance do
		assert_fails { eval('CALL 1') }
		assert_fails { eval('CALL "1"') }
		assert_fails { eval('CALL TRUE') }
		assert_fails { eval('CALL FALSE') }
		assert_fails { eval('CALL NULL') }
	end

	it 'requires exactly one argument', when_testing: :argument_count do
		assert_fails { eval('CALL') }
		assert_runs  { eval('CALL BLOCK 1') }
	end
end
