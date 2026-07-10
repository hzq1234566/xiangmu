import type { User } from './User';
import type { Shop, Location } from './Shop';
import type { Comment } from './Comment';

export interface Note {
  id: string;
  userId: string;
  shopId?: string;
  title: string;
  content: string;
  images: string[];
  rating: number;
  tags: string[];
  location?: Location;
  likeCount: number;
  commentCount: number;
  favoriteCount: number;
  viewCount: number;
  isLiked: boolean;
  isFavorited: boolean;
  createdAt: string;
  updatedAt?: string;
  user: User;
  shop?: Shop;
}

export interface NoteListResult {
  list: Note[];
  total: number;
  page: number;
  pageSize: number;
  hasMore: boolean;
}

export interface CreateNoteParams {
  userId: string;
  shopId?: string;
  title: string;
  content: string;
  images: string[];
  rating: number;
  tags: string[];
  location?: Location;
}

export interface NoteDetail extends Note {
  comments?: Comment[];
}

export interface Recommendation {
  id: string;
  title: string;
  shopName: string;
  image: string;
  rating: number;
  distance: number;
}
