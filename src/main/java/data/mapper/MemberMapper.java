package data.mapper;

import org.apache.ibatis.annotations.Mapper;

import data.dto.MemberDTO;

@Mapper
public interface MemberMapper {
	public void insertMember(MemberDTO dto);
	public int getIdCheck(String id);
	public int getNickCheck(String nick);
}
