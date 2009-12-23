require File.dirname(__FILE__) + '/../spec_helper'

describe PppamsIndicator do
  before(:all) do
    @pppams_indicator = PppamsIndicator.make
  end
  specify { @pppams_indicator.should respond_to(:pppams_indicator_base_ref) }
 
end
