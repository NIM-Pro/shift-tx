----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:46:47 12/12/2017 
-- Design Name: 
-- Module Name:    rs232 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity rs232 is
	port (
	-- 	1. ���������� �������
	-- 	1.1. �������� ������
		clock : in STD_LOGIC;
	--		1.2. ���������� ������� ��������
		transmit_enable : in STD_LOGIC;
		transmit_value : in STD_LOGIC_VECTOR (7 downto 0);
		transmit_busy : out STD_LOGIC;
	--		1.3. ���������� ������� �����
		receive_unlock : in STD_LOGIC;
		receive_done_interrupt : out STD_LOGIC;
		receive_value : out STD_LOGIC_VECTOR (7 downto 0);
	-- 	2. ������� �������
	-- 	2.1. ������� ������� ��������
		transmit_clear_to_send : in STD_LOGIC;
		transmit_ready_to_send : out STD_LOGIC;
		transmit_serial_output : out STD_LOGIC;
	-- 	2.1. ������� ������� �����
		receive_clear_to_send : out STD_LOGIC;
		receive_ready_to_send : in STD_LOGIC;
		receive_serial_input : in STD_LOGIC
	);
end rs232;

architecture Behavioral of rs232 is
	component rs232tx is
		Port ( enable : in  STD_LOGIC; --�������� �������
			value : in  STD_LOGIC_VECTOR (7 downto 0); --�������� �������
			clear_to_send : in  STD_LOGIC; --�������� �� ��������
			clock : in  STD_LOGIC; --�������� ������
			busy : out  STD_LOGIC; --�������� ������
			ready_to_send : out  STD_LOGIC; --�������� �� ��������
			serial_output : out  STD_LOGIC); --�������� �� ��������
	end component rs232tx;
	component rs232rx is
		Port ( unlock : in  STD_LOGIC; --�������� �������
			ready_to_send : in  STD_LOGIC; --�������� � ��������
			serial_input : in  STD_LOGIC; --�������� � ��������
			clock : in  STD_LOGIC; --�������� ������
			clear_to_send : out  STD_LOGIC; --�������� �� ��������
			done_interrupt : out  STD_LOGIC; --�������� ������
			value : out  STD_LOGIC_VECTOR (7 downto 0)); --�������� ������
	end component rs232rx;
begin
	transmitter: rs232tx
		port map (
			enable => transmit_enable,
			value => transmit_value,
			clear_to_send => clear_to_send,
			clock => clock,
			busy => transmit_busy,
			ready_to_send => ready_to_send,
			serial_output => serial_signal
		);
	receiver: rs232rx
		port map (
			unlock => receive_unlock,
			ready_to_send => ready_to_send,
			serial_input => serial_signal,
			clock => clock,
			clear_to_send => clear_to_send,
			done_interrupt => receive_done_interrupt,
			value => receive_value
		); 
end Behavioral;
