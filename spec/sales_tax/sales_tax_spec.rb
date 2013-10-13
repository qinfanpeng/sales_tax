require 'spec_helper'

describe SalesTaxCalculator do
  let(:order_parser) { OrderParser.new }

  describe 'only one' do
    context 'non-imported' do
      it 'exempt item' do
        order = order_parser.parse ['2 books at 12.49']
        expect(order.check_out.show).to eq [
                                        '2 books: 24.98',
                                        'Sales Taxes: 0.00',
                                        'Total: 24.98']
      end
      it "non-exempt item" do
        order = order_parser.parse ['2 music CDs at 14.99']
        expect(order.check_out.show).to eq [
                                        '2 music CDs: 32.98',
                                        'Sales Taxes: 3.00',
                                        'Total: 32.98']
      end
    end
    context 'imported' do
      it 'exempt item' do
        order = order_parser.parse ['2 imported boxes of chocolates at 10.00']
        expect(order.check_out.show).to eq [
                                        '2 imported boxes of chocolates: 21.00',
                                        'Sales Taxes: 1.00',
                                        'Total: 21.00']
      end
      it 'non-exempt item' do
        order = order_parser.parse ['2 imported bottles of perfume at 47.50']
          expect(order.check_out.show).to eq [
                                          '2 imported bottles of perfume: 109.30',
                                          'Sales Taxes: 14.30',
                                          'Total: 109.30']
      end
    end
  end


  describe 'more than one' do
    context 'non-imported' do
      it 'exempt items' do
        order = order_parser.parse [
                             '1 book at 12.49',
                             '1 chocolate bar at 0.85']
        expect(order.check_out.show).to eq [
                                        '1 book: 12.49',
                                        '1 chocolate bar: 0.85',
                                        'Sales Taxes: 0.00',
                                        'Total: 13.34']
      end
      it "non-exempt items" do
        order = order_parser.parse [
                             '2 music CDs at 14.99',
                             '1 bottle of perfume at 18.99']
        expect(order.check_out.show).to eq [
                                        '2 music CDs: 32.98',
                                        '1 bottle of perfume: 20.89',
                                        'Sales Taxes: 4.90',
                                        'Total: 53.87']
      end
      it "exempt or no-exempt items", focus: true do
        order = order_parser.parse [
                             '1 book at 12.49',
                             '1 music CD at 14.99',
                             '1 chocolate bar at 0.85']
        expect(order.check_out.show).to eq [
                                         '1 book: 12.49',
                                         '1 music CD: 16.49',
                                         '1 chocolate bar: 0.85',
                                         'Sales Taxes: 1.50',
                                         'Total: 29.83']
      end
    end
    context 'imported' do
      it 'exempt items' do
        order = order_parser.parse [
                             '1 imported box of chocolates at 10.00',
                             '1 box of imported chocolates at 11.25']
        expect(order.check_out.show).to eq [
                                        '1 imported box of chocolates: 10.50',
                                        '1 box of imported chocolates: 11.85',
                                        'Sales Taxes: 1.10',
                                        'Total: 22.35']
      end
      it "non-exempt items" do
        order = order_parser.parse [
                             '1 imported bottle of perfume at 47.50',
                             '1 imported bottle of perfume at 27.99']
        expect(order.check_out.show).to eq [
                                        '1 imported bottle of perfume: 54.65',
                                        '1 imported bottle of perfume: 32.19',
                                        'Sales Taxes: 11.35',
                                        'Total: 86.84']
      end
      it "exempt or no-exempt items", focus: true do
        order = order_parser.parse [
                             '1 imported box of chocolates at 10.00',
                             '1 imported bottle of perfume at 47.50']
        expect(order.check_out.show).to eq [
                                        '1 imported box of chocolates: 10.50',
                                        '1 imported bottle of perfume: 54.65',
                                        'Sales Taxes: 7.65',
                                        'Total: 65.15']
      end
    end
    context 'non-imported or imported' do
      it "exempt or no-exempt items", focus: true do
        order = order_parser.parse [
                             '1 imported bottle of perfume at 27.99',
                             '1 bottle of perfume at 18.99',
                             '1 packet of headache pills at 9.75',
                             '1 box of imported chocolates at 11.25']

        expect(order.check_out.show).to eq [
                                  '1 imported bottle of perfume: 32.19',
                                  '1 bottle of perfume: 20.89',
                                  '1 packet of headache pills: 9.75',
                                  '1 box of imported chocolates: 11.85',
                                  'Sales Taxes: 6.70',
                                  'Total: 74.68']
      end
    end
  end
end
