package data.mapper;

import java.security.Principal;
import java.util.HashMap;
import org.apache.ibatis.annotations.Mapper;
import data.dto.MemberDTO;

@Mapper
public interface MemberMapper {
	public void insertMember(MemberDTO dto);
	public int getIdCheck(String id);
	public int getNickCheck(String nick);
	public String getPw(String id);
	public String getNick(String id);
	public MemberDTO getMemberId(String id);
	public String getIdFindMember(HashMap<String, String> map);
	public String currentUserName(String id);
	public String currentUserNickName(String id);
	public String currentUserType(String id);
}
