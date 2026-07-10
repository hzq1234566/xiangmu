export interface User {
  id: string;
  nickname: string;
  avatar: string;
  bio?: string;
  gender?: number;
  followerCount: number;
  followingCount: number;
  noteCount: number;
  likeCount: number;
  isFollowed: boolean;
  createdAt?: string;
}

export interface UserProfile extends User {
  phone?: string;
  location?: string;
  birthday?: string;
}

export interface LoginResult {
  token: string;
  user: User;
}
