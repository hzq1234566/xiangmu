export interface Location {
  lat: number;
  lng: number;
  address: string;
  city?: string;
  district?: string;
}

export interface ShopCategory {
  id: string;
  name: string;
  icon?: string;
}

export interface Shop {
  id: string;
  name: string;
  categoryId: string;
  categoryName: string;
  address: string;
  location: Location;
  rating: number;
  ratingCount: number;
  coverImage: string;
  images: string[];
  phone?: string;
  businessHours?: string;
  avgPrice?: number;
  noteCount: number;
  isFavorited?: boolean;
  distance?: number;
}

export interface ShopListResult {
  list: Shop[];
  total: number;
  page: number;
  pageSize: number;
}
