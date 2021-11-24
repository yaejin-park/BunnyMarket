package data.mapper;

import org.apache.ibatis.annotations.Mapper;

import data.dto.MemberDTO;

@Mapper
public interface MemberMapper {
	public void insertMember(MemberDTO dto);
}
