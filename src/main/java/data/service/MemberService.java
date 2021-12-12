package data.service;

import java.security.Principal;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import data.dto.MemberDTO;
import data.mapper.MemberMapper;

@Service
public class MemberService implements UserDetailsService {
	
	@Autowired
	MemberMapper mapper;
	
	public void insertMember(MemberDTO dto) {
		mapper.insertMember(dto);
	}
	
	public int getIdCheck(String id) {
		return mapper.getIdCheck(id);
	}
	
	public int getNickCheck(String nick) {
		return mapper.getNickCheck(nick);
	}
	
	public String getPw(String id) {
		return mapper.getPw(id);
	}
	
	public String getNick(String id) {
		return mapper.getNick(id);
	}
	
	public String getIdFindMember(HashMap<String, String> map) {
		return mapper.getIdFindMember(map);
	}
	
	public MemberDTO getMemberId(String id) {
		return mapper.getMemberId(id);
	}
	
	public UserDetails loadUserByUsername(String id) throws UsernameNotFoundException {		
		MemberDTO member = mapper.getMemberId(id);
		
		if(member == null) throw new UsernameNotFoundException("Not Fount account");
		
		return member;
	}
	
	public String currentUserName(Principal principal) {
		String currentUserId = principal.getName();
		String currentUserName = mapper.currentUserName(currentUserId);
		
		return currentUserName;
	}
	
	public String currentUserNickName(Principal principal) {
		String currentUserId = principal.getName();
		String currentUserNickName = mapper.currentUserNickName(currentUserId);
		
		return currentUserNickName;
	}
	
	public String currentUserType(Principal principal) {
		String currentUserId = principal.getName();
		String currentUserType = mapper.currentUserType(currentUserId);
		
		return currentUserType;
	}
	
	public String currentLocal(String id) {
		return mapper.currentLocal(id);
	}
	
	public void updateCurrentLocal(HashMap<String, String> map) {
		mapper.updateCurrentLocal(map);
	}
	
	public String getLocal(Principal principal) {
		String currentUserId = principal.getName();
		String currentUserLocal = mapper.getLocal(currentUserId);
		
		return currentUserLocal;
	}
	
	public void updateLocal(HashMap<String, String> map) {
		mapper.updateLocal(map);
	}
	
	public String checkPw(HashMap<String, String> map) {
		return mapper.checkPw(map);
	}
	
	public void updatePw(HashMap<String, String> map) {
		mapper.updatePw(map);
	}
	
	public void updateProfile(HashMap<String, String> map) {
		mapper.updateProfile(map);
	}
	
	public void updateNickName(HashMap<String, String> map) {
		mapper.updateNickName(map);
	}
	
	public void updateMember(MemberDTO dto) {
		mapper.updateMember(dto);
	}
	
	public void deleteMember(String id) {
		mapper.deleteMember(id);
	}
	
	public String checkLocal(HashMap<String, String> map) {
		return mapper.checkLocal(map);
	}
	
	public String getIdTakeNick(String nickname) {
		return mapper.getIdTakeNick(nickname);
	}
}
