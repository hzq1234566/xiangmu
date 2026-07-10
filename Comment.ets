import type { User } from './User';

export interface Comment {
  id: string;
  noteId: string;
  userId: string;
  content: string;
  likeCount: number;
  isLiked: boolean;
  replyTo?: string;
  replyToUser?: User;
  createdAt: string;
  user: User;
}

export interface CommentListResult {
  list: Comment[];
  total: number;
  page: number;
  pageSize: number;
}
