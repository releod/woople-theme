require 'spec_helper'

describe WoopleTheme::Dashboard::EssentialsSectionPresenter do
  describe "#render_remaining" do
    describe "more than one essential remaining" do
      let(:data) { stub_presenter([stub]) }
      subject { WoopleTheme::Dashboard::EssentialsSectionPresenter.new(data) }
      it "yields the block" do
        expect { |block| subject.render_remaining(&block) }.to yield_control
      end
    end
    describe "0 essentials remaining" do
      let(:data) { stub_presenter }
      subject { WoopleTheme::Dashboard::EssentialsSectionPresenter.new(data) }
      it "does not yield the block" do
        expect { |block| subject.render_remaining(&block)}.not_to yield_control
      end
    end
  end

  describe "#render_completed" do
    describe "more than one completed essential" do
      let(:data) { stub_presenter([],[stub]) }
      subject { WoopleTheme::Dashboard::EssentialsSectionPresenter.new(data) }
      it "yields the block" do
        expect { |block| subject.render_completed(&block) }.to yield_control
      end
    end
    describe "0 completed essentials" do
      let(:data) { stub_presenter }
      subject { WoopleTheme::Dashboard::EssentialsSectionPresenter.new(data) }
      it "does not yields the block" do
        expect { |block| subject.render_completed(&block)}.not_to yield_control
      end
    end
  end

  describe '#total_completed_courses' do
    let(:data) { stub_presenter([],[stub]) }
    subject { WoopleTheme::Dashboard::EssentialsSectionPresenter.new(data) }
    it 'totals the completed courses' do
      subject.total_completed_courses.should == 1
    end
  end

  describe '#total_completed_minutes' do
    let(:data) { stub_presenter([],[stub(time_total: 1000)]) }
    subject { WoopleTheme::Dashboard::EssentialsSectionPresenter.new(data) }
    it 'totals the completed courses time in minutes' do
      subject.total_completed_minutes.should == "0:01"
    end
  end
  def stub_presenter(remaining=[], completed=[])
    stub({title:'title', enabled?: true, essentials_remaining: remaining, essentials_completed: completed})
  end
end
