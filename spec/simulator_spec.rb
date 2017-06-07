require 'spec_helper'

RSpec.describe ToyRobot::Simulator do

  let(:simulator) { ToyRobot::Simulator.new }

  describe "#place" do

    it "returns the placed coordinates" do
      expect(simulator.place("1,1,NorTH")).to eql(x: 1, y: 1)
    end

    it "raises an exception if direction is invalid" do
      expect { simulator.place("1,1,NORTHWEST") }
        .to raise_exception ToyRobot::InvalidDirection
    end

    it "raises an exception if co-ordinates are invalid" do
      expect { simulator.place("6,1,NORTH") }
        .to raise_exception ToyRobot::InvalidPosition
    end

  end

  describe "#move" do

    it "returns the new valid robot position" do
      simulator.place("1,1,NORTH")
      expect(simulator.move).to eql(x: 1, y: 2)
    end

    it "raises an exception if it moves robot off the table top" do
      simulator.place("4,4,NORTH")
      expect { simulator.move }.to raise_exception ToyRobot::InvalidPosition
    end

    it "raises an exception if robot has not been placed" do
      expect { simulator.move }.to raise_exception ToyRobot::InvalidPlacement
    end

  end

  describe "#left" do
    it "robot turns to face left" do
      simulator.place("1,1,NORTH")
      expect(simulator.left).to eql("1,1,WEST")
    end
  end

  describe "#right" do
    it "robot turns to face right" do
      simulator.place("1,1,NORTH")
      expect(simulator.right).to eql("1,1,EAST")
    end
  end

  describe "#report" do

    it "prints the current position" do
      simulator.place("1,1,NORTH")
      expect(simulator.report).to eql("1,1,NORTH")
    end
      context "when the robot is NOT placed" do

        it "raises an exception" do
          expect { simulator.report }.to raise_exception ToyRobot::InvalidPlacement
        end
      end
  end
end
